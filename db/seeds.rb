# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Appointment.destroy_all
JoinTableDoctorSpecialty.destroy_all
Specialty.destroy_all
City.destroy_all
Doctor.destroy_all
Patient.destroy_all


City.create(name: "Paris")
City.create(name: "Madrid")
City.create(name: "Londre")
City.create(name: "New-York")

Specialty.create(name: "Chrirurgien")
Specialty.create(name: "Generaliste")
Specialty.create(name: "Podologue")
Specialty.create(name: "Urologue")


100.times do
  doctor = Doctor.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, zip_code: rand(10000..99999), city: City.all.sample(1).first)
  patient = Patient.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, city: City.all.sample(1).first)
end

i = 0
100.times do
  array = Array.new
  rand(1..3).times do
    j = rand(0..3)
    while array.include?(j) == true
      j = rand(0..3)
    end
    JoinTableDoctorSpecialty.create(doctor: Doctor.all[i], specialty: Specialty.all[j])
    array.push(j)
  end
  i += 1
end

300.times do
  i = rand(0..3)
  Appointment.create(doctor: Doctor.where(city: City.all[i]).sample(1).first, patient: Patient.where(city: City.all[i]).sample(1).first, city: City.all[i], date: Faker::Time.forward(days: 365,  period: :day, format: :short))
end
