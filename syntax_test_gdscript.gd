# SYNTAX TEST "Packages/User/GDScript-sublime/GDScript.sublime-syntax"

" # not a comment"
#^^^^^^^^^^^^^^^^^ meta.string.gdscript string.quoted.double.gdscript
# <- punctuation.definition.string.begin.gdscript
#                ^ punctuation.definition.string.end.gdscript
' # not a comment'
#^^^^^^^^^^^^^^^^^ meta.string.gdscript string.quoted.double.gdscript
# <- punctuation.definition.string.begin.gdscript
#                ^ punctuation.definition.string.end.gdscript

'escaped quote \' foo'
#              ^^ constant.character.escape.gdscript
"escaped quote \" foo"
#              ^^ constant.character.escape.gdscript


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

# todo
func foo():
    var x = {func = 1}  
    var y = {signal = 1} 
