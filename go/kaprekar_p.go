package main

/*
 * kaprekar.go
 * 2016/07/27(Wed)
 * Kazuki Nagamine (145725A)
 * Program to find the kaprekar number using golang - Pararell version
 * Using load distribution
 */

// Packages
import (
  "fmt"
  "os"
  "runtime"
  "sort"
  "strconv"
  "strings"
  "time"
)

// Seek the kaprekar numbers
func kaprekar(cnt int) {
  // Convert int to String
  i := strconv.Itoa(cnt)

  // Sort bytes in ascending order
  j := strings.Split(i, "")
  sort.StringSlice(j).Sort()
  x, _ := strconv.Atoi(strings.Join(j, ""))

  // Sort bytes in descending order
  k := strings.Split(i, "")
  sort.Sort(sort.Reverse(sort.StringSlice(k)))
  y, _ := strconv.Atoi(strings.Join(k, ""))

  // Print the kaprekar number
  if (y - x) == cnt {
    fmt.Println(cnt)
  }
}

// A goroutine with tasks
func pararelloop(task []int, l int, ch chan bool) {
  for cnt := 0; cnt < l; cnt++ {
    kaprekar(task[cnt])
  }
  ch <- true
  if l == runtime.NumCPU() {
    close(ch)
  }
}

// Main
func main() {
  //
  start := time.Now()

  // Get the commandline arguments
  N, _ := strconv.Atoi(os.Args[1])

  // Get and set the processers num
  cpus := runtime.NumCPU()
  runtime.GOMAXPROCS(cpus)

  // for goroutine
  ch := make(chan bool)

  // Load distributed processing
  part := N / cpus
  tasks := make([][]int, cpus)

  for c := 0; c < cpus; c++ {
    tasks[c] = make([]int, part)
    for i, v := 0, c*part; v < (c+1)*part; v++ {
      tasks[c][i] = v
      i++
    }
    go pararelloop(tasks[c], part, ch)
  }
  <-ch

  end := time.Now()
  fmt.Printf("%f sec\n", (end.Sub(start)).Seconds())
}
