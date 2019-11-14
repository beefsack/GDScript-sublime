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

func foo():
# <- storage.type.function.gdscript
#    ^^^ entity.name.function.gdscript
    pass
#   ^^^^ keyword.control.flow.gdscript

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
         baz):
# ^^^^^^^^^^^ meta.function.parameters.gdscript 
#           ^ punctuation.section.parameters.end.gdscript
    pass

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
