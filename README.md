# std

Standard Streams Handlers.

## Using it

````bash
source path/to/std/source.bash

std_in -q "Input required"
echo "${STDIN}"
````

## Available functions

* [std_out][]
* [std_err][]
* [std_in][]

### std_out

The `std_out` function is basicaly a wrapper of `echo` build-in command, but there
are some gotchas you can also use.

#### Writing on STDOUT

As the same of `echo` build-in command, `std_out` function will always write on
*STDOUT*.

```bash
std_out "STDOUT write"
```

#### Writing a single line

This is the same behavior of `echo`.

```bash
std_out
```

#### Stylizing

Stylize texts on Bash sometimes sucks! You also have to write the escape char and
then write the style sequence; `std_out` use `-e` option on `echo` build-in
command by default, and also will replace values like `[1;31]` by `\033[1;31m`
when you're in a interactive shell.

```bash
std_out "[0;31]S[][0;32]t[][0;33]y[][0;34]l[][1;90]i[][0;103]z[][4;36]i[][0;36]n[][0;42]g[]"
```

#### Don't use new line

As the same of `echo` you can avoid use the new line at end.

```bash
std_out -n "No new line"
```

#### Don't escape

In that part `std_out` is exactly the opposite of `echo` build-in command. By
default, `echo` does not escape special chars and `std_out` does, but you also
can avoid this behavior if you want.

```bash
std_out -e "\nDo not escape line"
```

### std_err

With `std_err` you can use all options of `std_out` but the output will be write
on *STDERR* instead or *STDOUT*.

```bash
std_err "STDERR write"
```

### std_in

Using `std_in` you have a lot of options already available on `read` build-in
command, but there are some other helpful things you also can use.
In first the last input is stored on `STDIN` Bash variable, so, after you use
`std_in` you can get the value by calling `$STDIN`.

#### Input

```bash
std_in "Input"
```

Does not looks so better, but you can use the same styles you use on `std_out`
function to stylize the message.

#### Required input

It will not stop until you provide a value.

```bash
std_in -q "Input required"
```

#### Using readline

You can use readline as well as `read` build-in does.

```bash
std_in -e "Input using readline"
```

#### Defining a delimiter

You can define a delimiter as well as `read` build-in does.

```bash
std_in -d . "Input with delimiter \".\""
```

#### Defining a timeout

You can define a timeout as well as `read` build-in does.

```bash
std_in -t 2 "Input with timeout of 2 seconds"
```

#### Defining a limit of chars

You can define a limit of chars as well as `read` build-in does.

```bash
std_in -n 4 "Input with with limit of 4 chars"
```

#### Defining a preload

You can define a preload (default value) as well as `read` build-in does.

```bash
std_in -i "Preload" "Input with with a preload"
```

#### Custom prompt

By default, `std_in` uses `: ` as prompt, but you can customize it.

```bash
std_in -p "\n]> " "Input with custom prompt"
```

[std_out]: #std_out
[std_err]: #std_err
[std_in]: #std_in
