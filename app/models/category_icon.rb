class CategoryIcon < ActiveHash::Base
  self.data = [
    {id: 1, name: "graduation-cap", class: "fa-graduation-cap"},
    {id: 2, name: "car", class: "fa-car"},
    {id: 3, name: "pencil", class: "fa-pencil"},
    {id: 4, name: "user", class: "fa-user"},
    {id: 5, name: "users", class: "fa-users"},
    {id: 6, name: "check", class: "fa-check-square-o"},
    {id: 7, name: "building", class: "fa-building"}
  ]
end