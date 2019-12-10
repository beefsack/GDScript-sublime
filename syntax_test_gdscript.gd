# SYNTAX TEST "Packages/User/GDScript-sublime/GDScript.sublime-syntax"

""" # still a block comment """
#   ^ comment.block.documentation.gdscript

    """ indented block comment """
#   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ comment.block.documentation.gdscript
#   ^^^                            punctuation.definition.comment.begin.gdscript
#                              ^^^ punctuation.definition.comment.end.gdscript

""" \" """
#   ^^ constant.character.escape.gdscript

var x = """ # not a comment """
#       ^^^^^^^^^^^^^^^^^^^^^^^ meta.string.gdscript string.quoted.double.block.gdscript
#       ^^^                     punctuation.definition.string.begin.gdscript
#                           ^^^ punctuation.definition.string.end.gdscript
var x = """  " lone quote does not end the string
#            ^ string.quoted.double.block.gdscript
"""
var x = """ \""" """
#           ^^ constant.character.escape.gdscript


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

"\\"
#^^ constant.character.escape.gdscript
#  ^ punctuation.definition.string.end.gdscript
'\\'
#^^ constant.character.escape.gdscript
#  ^ punctuation.definition.string.end.gdscript


123  # this actually won't compile outside a function
# <- constant.numeric.integer.gdscript
#    ^ punctuation.definition.comment.number-sign.gdscript


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
(): pass  # not actually legal after the bad line continuation
# <- meta.function.parameters.gdscript 

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
func foo() -> void: pass
#             ^^^^ storage.type.basic.gdscript

func foo() -> FuncRef: pass
#             ^^^^^^^ support.class.gdscript


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

    print(yield())
#         ^^^^^ keyword.control.flow.yield.gdscript

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
            {int = foo}
    var e = {yield(): 'foo'}
#            ^^^^^ keyword.control.flow.yield.gdscript
    var x = {func = 1 + 1,
#            ^^^^   meta.mapping.key.gdscript
#                 ^ punctuation.separator.mapping.key-value.gdscript
#                   ^^^^^ meta.mapping.value.gdscript
#                        ^ meta.mapping.gdscript punctuation.separator.mapping.gdscript
             signal = 2,
#            ^^^^^^ meta.mapping.key.gdscript
             yield = 3,
#            ^^^^^ meta.mapping.key.gdscript
             int=4 }
#            ^^^ meta.mapping.key.gdscript
    var y = {signal = 3}
#            ^^^^^^ meta.mapping.key.gdscript

enum {}
# <- storage.type.enum.gdscript
enum FOO {BAR}
#         ^^^ entity.name.enum.gdscript
#    ^^^ entity.name.type.gdscript
#^^^ storage.type.enum.gdscript
enum {X, Y,Z}
#     ^       meta.mapping.key.gdscript entity.name.enum.gdscript
#        ^    meta.mapping.key.gdscript entity.name.enum.gdscript
#         ^   punctuation.separator.mapping.key-value.gdscript
#           ^ punctuation.section.mapping.end.gdscript
enum TEST {
    A, B, C
#   ^       meta.mapping.key.gdscript entity.name.enum.gdscript
#      ^    meta.mapping.key.gdscript entity.name.enum.gdscript
#         ^ meta.mapping.key.gdscript entity.name.enum.gdscript
}

  match state:
# ^^^^^ keyword.control.flow.gdscript
    STATE.INTRO:
        print("intro")

  class Thing:
# ^^^^^       storage.type.class.gdscript
#       ^^^^^ entity.name.type.class.gdscript

  class Thing extends Reference:
# ^^^^^                         storage.type.class.gdscript
#       ^^^^^                   entity.name.type.class.gdscript
#             ^^^^^^            keyword.other.gdscript
#                     ^^^^^^^^^ entity.other.inherited-class.gdscript