package todo_UseCases

import todo_Domains.TodoItem
import todo_Repository.addTodo
import todo_Repository.getAllToDos
import todo_Repository.getToDo

class AddToDoUseCase {
    fun addToDo(  Item: TodoItem){
       return addTodo(Item)
    }
}