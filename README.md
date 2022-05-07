# Nrepl

work in progress to create an [nREPL server](https://nrepl.org/nrepl/design/overview.html) for ruby. because if ruby is basically a lisp already anyway, it should have a much better repl.

consider this version 0.0.1 - this is purely for my own edification about all the topics related to nREPL support.

## Usage

`rake nrepl` in the gem directory for now. it will log the server port. the process also creates an `nrepl.port` file with the port number

`nc localhost $(cat nrepl.port)` in a new window will show the connection info.

```
nREPL server started on port 52767 on host 0.0.0.0 - nrepl://0.0.0.0:52767
{:op "eval" :code "3*(4+3)"}
{:out "\"\"", :value 21M, :id "7c68644f-283c-4cdd-870b-0f5dcf24ed52", :ns "main", :err nil}
^C
```

ctrl-c to quit. disconnect should shut down the nrepl server as well.

# Todo

Supported Transport protocols:

- [ ] Bencode
- [x] EDN
- [ ] TTY

Supported nREPL ops:

- [ ] add-middleware
- [ ] clone
- [ ] close
- [ ] completions
- [ ] describe
- [x] eval
- [ ] interrupt
- [ ] load-file
- [ ] lookup
- [ ] ls-middleware
- [ ] ls-sessions
- [ ] sideloader-provide
- [ ] sideloader-start
- [ ] stdin
- [ ] swap-middleware