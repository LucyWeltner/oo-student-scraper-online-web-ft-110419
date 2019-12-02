class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    student_hash.each do |attribute, value|
      self.send("#{attribute}=", value)
      @@all << self
    end
  end

  def self.create_from_collection(students_array)
    students_array.each do |student_info|
      student_hash = {}
      student_hash[:name] = student_info.css("h4").text
      student_hash[:location] = student_info.css("p").text
      Student.new(student_hash)
    end
  end

  # def add_student_attributes(attributes_hash)
    
  # end

  def self.all
    @@all
  end
end

