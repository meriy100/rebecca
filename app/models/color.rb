class Color < ActiveHash::Base
  self.data = [
    { id: 1, name: "red", code: "#e74c3c" },
    { id: 2, name: "blue", code: "#3498db" },
    { id: 3, name: "green", code: "#2ecc71" },
    { id: 4, name: "purple", code: "#9b59b6" }
  ]
end
