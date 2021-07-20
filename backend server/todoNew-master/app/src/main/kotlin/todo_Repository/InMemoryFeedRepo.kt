package todo_Repository

import todo_Domains.TodoItem


private val todos = mutableListOf<TodoItem>(
    TodoItem(
        1,"something",false
))
//private val todos = listOf(todo1, todo2)
fun getAllToDos(): List<TodoItem> {
    return todos
}
fun addTodo(item: TodoItem) {
    val todo = TodoItem(
        id = todos.size + 1,
        details = item.details,
        status = item.status
    )
    todos.add(todo)

}

fun getToDo(id: Int): TodoItem {
    return todos.elementAt(id-1)

}
fun updateTodo(id: Int, item: TodoItem): Boolean {
    val todo = todos.firstOrNull { it.id == id }
        ?: return false

    todo.details = item.details
    todo.status = item.status
    return true
}
fun removeTodo(id: Int): Boolean {
    return todos.removeIf { it.id == id }
}


