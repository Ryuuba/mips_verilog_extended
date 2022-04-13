int factorial(int);

int main() {
  int n = factorial(5);
  return 0;
}

int factorial(int x) {
  if (x > 1)
    return x * factorial(x - 1);
  else
    return 1;
}
