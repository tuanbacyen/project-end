User.create!(
  email: "admin@gmail.com",
  phone: "0900000000",
  password: "123456",
  name: "admin",
  role: "admin",
  confirmed: true,
  working: true,
  avatar: File.open(File.join(Rails.root, "app/assets/images/user2-160x160.jpg"))
)
