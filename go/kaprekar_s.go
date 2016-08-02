package main

/*
 * kaprekar_s.go
 * 2016/07/27(Wed)
 * Kazuki Nagamine (145725A)
 * Program to find the kaprekar number using golang - Sirial version
 */

// Packages
import (
    "fmt"
    "strconv"
    "sort"
    "strings"
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

// Main
func main() {
  //
  start := time.Now();

  // Get the commandline arguments
  N,_ := strconv.Atoi(os.Args[1])

  // A sirial loop
  for cnt := 0; cnt < N; cnt++ {
      kaprekar(cnt)
  }

  //
  end := time.Now();
  fmt.Printf("%f sec\n",(end.Sub(start)).Seconds())
}
