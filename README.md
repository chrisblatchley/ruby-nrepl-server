# Nrepl

work in progress to create an [nREPL server](https://nrepl.org/nrepl/design/overview.html) for ruby. because if ruby is basically a lisp already anyway, it should have a much better repl.

consider this version 0.0.1

## Usage

`rake nrepl` in the gem directory for now. it will log the server port.

`nc localhost 60539` or whatever port was printed above.

```
{op: "eval", code: "3 + 2"}
{:id=>"4ad2bdee-07eb-4e02-b224-606ab79a5562", :ns=>"main", :out=>"", :err=>"", :value=>5}
^C
```

ctrl-c to quit. disconnect should shut down the nrepl server as well.
