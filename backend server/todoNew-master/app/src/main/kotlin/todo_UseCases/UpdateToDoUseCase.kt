package todo_UseCases

import todo_Domains.TodoItem
import todo_Repository.updateTodo

class UpdateToDoUseCase {
    fun update(id:Int, todo:TodoItem):Boolean{
        return updateTodo(id,todo)

    }
}