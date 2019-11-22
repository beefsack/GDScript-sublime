This rewrites most of the syntax file. It resolves https://github.com/beefsack/GDScript-sublime/issues/13 and adds partial Godot 3.1 support for https://github.com/beefsack/GDScript-sublime/issues/16

I merged these existing pull request first, so if this pull request gets merged, Github should mark these as merged as well:

- https://github.com/beefsack/GDScript-sublime/pull/18
- https://github.com/beefsack/GDScript-sublime/pull/17
- https://github.com/beefsack/GDScript-sublime/pull/15

Adds syntax test file though it doesn't test everything, just the changes I made.

I deleted the `tmLanguage` versions of the syntax because I wanted to work in the `sublime-syntax` format without risk of things getting out of sync. Might need to regenerate the `tmLanguage` file when publishing the plugin if this needs to support Sublime 2.

Guidelines for reference: https://www.sublimetext.com/docs/3/scope_naming.html


## Entities used just for definitions

Most text now renders as white (in the default color scheme) instead of orange:

[picture]

This is because the previous syntax scoped many things under `entity`, but `entity` should normally be used just where things are defined. So, now, function names appear orange only where the function is defined, not where it's called.


## Return types

Pull request https://github.com/beefsack/GDScript-sublime/pull/15 added function modifiers, such as `remote` and https://github.com/beefsack/GDScript-sublime/pull/17 added the `-> ReturnValue` syntax. The result of merging these was that the return value wasn't supported on all modified functions:

[picture]

I dried that up.


## Dictionaries

Adding dictionary scoping, so keywords used as dictionary keys don't get highlighted as keywords. For instance, `func` here is a valid dictionary key:

[picture]


## Comments

Comments can go inside function params:

[picture]


## Signals

Pull request https://github.com/beefsack/GDScript-sublime/pull/15 partly fixed `signal` highlighting as an error, but only in the case where the signal had parameters. `signal` can also be declared without params, so both of these are now valid::

[picture]

## Small things

- Line continuations
- Use `comment.block.documentation` for docstrings to follow Sublime guidelines
- Escaped quotes are tagged in strings
- Automatic indentation


## More that ought to be done

Not addressed in this pull request:

- Support `$NodePath` syntax
- Figure out how node paths should really be scoped, maybe `meta.path`
- Update builtin names. For example, there are constants PI and TAU, and Godot 3 uses different names for specific Array types, for example, PoolByteArray
- Static typing forms `x := 2`, `x: int` and `func(x: int)`
- Character escape sequences aside from escaped quotes
- Sprintf language
- `funcref` isn't actually a builtin type (anymore?) it's a builtin function that returns `FuncRef`
- Nested parens in function calls: in `f((1+1) / 2)`, the `meta.function-call.arguments` scope ends at the first closing paren
