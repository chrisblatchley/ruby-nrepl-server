# Nrepl

work in progress to create an [nREPL server](https://nrepl.org/nrepl/design/overview.html) for ruby. because if ruby is basically a lisp already anyway, it should have a much better repl.

consider this version 0.0.1 - this is purely for my own edification about all the topics related to nREPL support.

## Usage

`rake nrepl` in the gem directory for now. the process creates an `nrepl.port` file with the port number. it defaults to the tty transport mode which provides a familiar looking REPL interface, but you can specify an alternative mode with `rake nrepl[edn]`.

```
➜  nrepl git:(master) ✗ rake nrepl
nREPL server started on port 56204 on host 0.0.0.0 - nrepl://0.0.0.0:56204
```

running `nc localhost $(cat nrepl.port)` elsewher will connect and show the connection info.

```
➜  nrepl git:(master) ✗ nc localhost $(cat nrepl.port)
nREPL server started on port 56204 on host 0.0.0.0 - nrepl://0.0.0.0:56204
Ruby 3.0.2
(main)=> (1..4).each { |v| puts v }
1
2
3
4
1..4
(main)=>
```

ctrl-c to quit. disconnect should shut down the nrepl server as well.

# Todo

Supported Transport protocols:

- [x] Bencode
- [x] EDN
- [x] TTY

Supported nREPL ops:

- [ ] add-middleware
- [ ] clone
- [ ] close
- [ ] completions
- [x] describe
- [x] eval (very very very basic)
- [ ] interrupt
- [ ] load-file
- [ ] lookup
- [ ] ls-middleware
- [ ] ls-sessions
- [ ] sideloader-provide
- [ ] sideloader-start
- [ ] stdin
- [ ] swap-middleware
