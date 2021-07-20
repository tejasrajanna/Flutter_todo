package todo_UseCases

import todo_Repository.removeTodo

class DeleteToDoUseCase {
    fun delete(id:Int):Boolean{
       return removeTodo(id)

    }
}