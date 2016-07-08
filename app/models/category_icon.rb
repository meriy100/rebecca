class CategoryIcon < ActiveHash::Base
  self.data = [
    { id: 1, name: "graduation-cap", class_name: "fa-graduation-cap" },
    { id: 2, name: "car", class_name: "fa-car" },
    { id: 3, name: "pencil", class_name: "fa-pencil" },
    { id: 4, name: "user", class_name: "fa-user" },
    { id: 5, name: "users", class_name: "fa-users" },
    { id: 6, name: "check", class_name: "fa-check-square-o" },
    { id: 7, name: "building", class_name: "fa-building" }
  ]
end
