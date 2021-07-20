package todoNew



import io.ktor.application.*
import io.ktor.http.*
import io.ktor.request.*
import io.ktor.response.*
import io.ktor.routing.*
import todo_Domains.TodoItem
import todo_UseCases.AddToDoUseCase
import todo_UseCases.DeleteToDoUseCase

import todo_UseCases.GetToDosUseCase
import todo_UseCases.UpdateToDoUseCase



val getTodos= GetToDosUseCase()
val addTodo= AddToDoUseCase()
val updateTodo= UpdateToDoUseCase()
val deleteTodo= DeleteToDoUseCase()

fun Routing.todoApi(){
    route("/api") {

//GET
        get("/todos") {
            val todos = getTodos.getToDo()
            call.respond(todos)
                    }
        get("/todos/{id}"){
            val id= call.parameters["id"]!!

            try{
                val todo = getTodos.getSingleToDo(id.toInt())
                call.respond(todo)
            }catch(e :Throwable){
                call.respond(HttpStatusCode.NotFound)
            }
        }

//POST
        post("/todos") {
            val todo = call.receive<TodoItem>()

            addTodo.addToDo(todo)
            call.respond(HttpStatusCode.Created,
                "new entry has been created!")
        }

//PUT
        put("/todos/{id}"){
            val todo = call.receive<TodoItem>()
            val id = call.parameters["id"]?.toIntOrNull()

            if (id == null) {
                call.respond(HttpStatusCode.BadRequest,
                    "id parameter has to be a number!")
                return@put
            }

            val updated = updateTodo.update(id.toInt(), todo)

            if (updated) {
                call.respond(getTodos.getSingleToDo(id))
            } else {
                call.respond(HttpStatusCode.NotFound,
                    "found no todo with the id $id")
            }
        }


//DELETE
        delete("todos/{id}") {
            val id = call.parameters["id"] ?: throw IllegalArgumentException("Missing id")
            val removed = deleteTodo.delete(id.toInt())
            if (removed) {
                call.respond(HttpStatusCode.OK)
            } else {
                call.respond(HttpStatusCode.NotFound,
                    "found no todo with the id $id")
            }

        }
    }

}


