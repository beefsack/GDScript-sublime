# SYNTAX TEST "Packages/User/GDScript-sublime/GDScript.sublime-syntax"

" # not a comment"
#^^^^^^^^^^^^^^^^^ meta.string.gdscript string.quoted.double.gdscript
# <- punctuation.definition.string.begin.gdscript
#                ^ punctuation.definition.string.end.gdscript
' # not a comment'
#^^^^^^^^^^^^^^^^^ meta.string.gdscript string.quoted.single.gdscript
# <- punctuation.definition.string.begin.gdscript
#                ^ punctuation.definition.string.end.gdscript

'escaped quote \' foo'
#              ^^ constant.character.escape.gdscript
"escaped quote \" foo"
#              ^^ constant.character.escape.gdscript

123  # this actually won't compile outside a function
# <- constant.numeric.integer.gdscript

func foo(): pass
# <- storage.type.function.gdscript
#    ^^^ entity.name.function.gdscript
#           ^^^^ keyword.control.flow.gdscript
static func f(): pass
# <- storage.modifier.gdscript
remote func f(): pass
# <- storage.modifier.gdscript 
sync func f(): pass
# <- storage.modifier.gdscript 
master func f(): pass
# <- storage.modifier.gdscript 
slave func f(): pass
# <- storage.modifier.gdscript 

func foo () :
#^^^^^^^^ meta.function.gdscript
#        ^^ meta.function.parameters.gdscript
#           ^ punctuation.section.function.begin.gdscript
#          ^^ meta.function.gdscript
    pass

func foo(bar,  # something
#       ^ punctuation.section.parameters.begin.gdscript
#        ^^^ variable.parameter.gdscript
#           ^ punctuation.separator.parameters.gdscript
#              ^^^^^^^^^^^ comment.line
         baz): pass
# ^^^^^^^^^^^ meta.function.parameters.gdscript 
#           ^ punctuation.section.parameters.end.gdscript
func foo \
(): pass
# <- meta.function.parameters.gdscript 
func foo \  # nothing allowed after
#        ^ punctuation.separator.continuation.line.gdscript
#         ^^^^^^^^^^^^^^^^^^^^^^^^^ invalid.illegal.unexpected-text.gdscript

func foo() -> int:
#          ^^ keyword.operator.arrow.forward.gdscript
#             ^^^ storage.type.basic.gdscript
    int(1)
#   ^^^ storage.type.basic.gdscript
func foo() -> Vector2:
#          ^^ keyword.operator.arrow.forward.gdscript
#             ^^^^^^^ storage.type.vector.gdscript
    Vector2(1,2)
#   ^^^^^^^ storage.type.vector.gdscript

func foo() -> FuncRef: pass
#             ^^^^^^^ support.class.gdscript

func foo() -> funcref: pass # todo: illegal


signal foo
# <- storage.type.signal.gdscript
#      ^^^ entity.name.signal.gdscript
signal foo()
#^^^^^^^^^ meta.signal.gdscript
#         ^^ meta.signal.parameters.gdscript
#         ^  punctuation.section.parameters.begin.gdscript
#          ^ punctuation.section.parameters.end.gdscript
signal foo(bar, baz)
#          ^^^ variable.parameter.gdscript
#             ^ punctuation.separator.parameters.gdscript
signal foo \
()
# < meta.signal.parameters.gdscript

var x setget set_x
#            ^^^^^ variable.function.setter.gdscript
var x setget set_x, get_x
#            ^^^^^ variable.function.setter.gdscript
#                 ^ punctuation.separator.parameters.gdscript
#                   ^^^^^ variable.function.getter.gdscript
var x setget, get_x
#             ^^^^^ variable.function.getter.gdscript
var x setget set_x ,get_x
#            ^^^^^ variable.function.setter.gdscript
#                   ^^^^^ variable.function.getter.gdscript

func foo():
    bar()
#   ^^^ meta.function-call.gdscript variable.function.gdscript
    bar('foo', 1 + 1)
#      ^^^^^^^^^^^^^^ meta.function-call.arguments.gdscript
#       ^^^^^  meta.string.gdscript string.quoted.single.gdscript
    bar('foo', 1 + 1)
#                   ^ punctuation.section.arguments.end.gdscript
#            ^ punctuation.separator.arguments.gdscript
#      ^ punctuation.section.arguments.begin.gdscript
    yield()
#   ^^^^^ keyword.control.flow.yield.gdscript
    yield('foo', 1 + 1)
#         ^^^^^  meta.string.gdscript string.quoted.single.gdscript
    yield('foo', 1 + 1)
#                     ^ punctuation.section.arguments.end.gdscript
#              ^ punctuation.separator.arguments.gdscript
#        ^ punctuation.section.arguments.begin.gdscript


func foo():
    var a = {}
#           ^  meta.mapping.gdscript punctuation.section.mapping.begin.gdscript
#            ^ meta.mapping.gdscript punctuation.section.mapping.end.gdscript
#           ^^ meta.mapping.gdscript
    var b = {'foo': 1}
#            ^^^^^ meta.mapping.key.gdscript meta.string.gdscript string.quoted.single.gdscript
#                 ^ meta.mapping.gdscript punctuation.separator.mapping.key-value.gdscript
#                   ^ meta.mapping.value.gdscript constant.numeric.integer.gdscript
    var c = {key: 1}
#            ^^^ meta.mapping.key.gdscript
    var d = { # things
#             ^^^^^^^^ comment.line
            'foo':
#           ^^^^^ meta.mapping.key.gdscript
                'bar'
#               ^^^^^ meta.mapping.value.gdscript
            }
    var x = {func = 1 + 1,
#            ^^^^   meta.mapping.key.gdscript
#                 ^ punctuation.separator.mapping.key-value.gdscript
#                   ^^^^^ meta.mapping.value.gdscript
#                        ^ meta.mapping.gdscript punctuation.separator.mapping.gdscript
             signal = 2 }
#            ^^^^^^ meta.mapping.key.gdscript
    var y = {signal = 3}
#            ^^^^^^ meta.mapping.key.gdscript
    var z = {yield = 4}
#            ^^^^^ meta.mapping.key.gdscript
