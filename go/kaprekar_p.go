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
    "strconv"
    "sort"
    "strings"
    "sync"
    "runtime"
    "os"
    "time"
)

// Seek the kaprekar numbers
func kaprekar(cnt int) {
  // Convert int to String
  i := strconv.Itoa(cnt)

  // Sort bytes in ascending order
  j := strings.Split(i, "")
  sort.StringSlice(j).Sort()
  x,_ := strconv.Atoi(strings.Join(j, ""))

  // Sort bytes in descending order
  k := strings.Split(i, "")
  sort.Sort(sort.Reverse(sort.StringSlice(k)))
  y,_ := strconv.Atoi(strings.Join(k, ""))

  // Print the kaprekar number
  if (y - x) == cnt {
    fmt.Println(cnt)
  }
}

// A goroutine with tasks
func pararelloop(task []int, l int) {
  for cnt := 0; cnt < l; cnt++ {
    kaprekar(task[cnt])
  }
}

// Main
func main() {
  //
  start := time.Now();

  // Get the commandline arguments
  N,_ := strconv.Atoi(os.Args[1])
  
  // Get and set the processers num
  cpus := runtime.NumCPU()
  runtime.GOMAXPROCS(cpus)

  // Load distributed processing
  tasks := make([][]int, cpus)
  for i := 0; i < N; i++ {
    tasks[i%cpus] = append(tasks[i%cpus], i)
  }

  // Start goroutine with waitcontroller
  var wg sync.WaitGroup
  for c := 0; c < cpus; c++ {
    wg.Add(1)
    go func(task []int, l int) {
      defer wg.Done()
      pararelloop(task, l)
    }( tasks[c], N/cpus )
  }
  wg.Wait()

  //
  end := time.Now();
  fmt.Printf("%f sec\n",(end.Sub(start)).Seconds())
}