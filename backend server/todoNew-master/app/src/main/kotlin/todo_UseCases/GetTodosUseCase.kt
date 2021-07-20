package todo_UseCases

;

import todo_Domains.TodoItem

import todo_Repository.*


class GetToDosUseCase {
    fun getToDo(): List<TodoItem> {
        return getAllToDos()
  }
    fun getSingleToDo(id: Int) :TodoItem{
        return getToDo(id)
    }
}
