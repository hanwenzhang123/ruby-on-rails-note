class Person

  def name    #getter
    @name
  end

  def name=(value)  #setter
    @name = value
  end

end


class Person

  attr_reader :name
  attr_writer :name

end


class Person

  attr_reader :name, :age, :gender

  def initilize(name, age, gender)
    @name = name
    @age = gender
    @gender = gender
  end

end


class Person

  option :name

end


class GetMemberId

  option :id

  def process

  return failure(data: { id: 'Id is neither Ineger not String'}) if !id.is_a?(Integer) || !id.is_a?(String)


    member = Member.find_by(id: id)

    if member

    if member.id

      return success(data: { id: member.id })

    else

      return error(message: 'Member is found, but he/she has no id.')

    end

    else

      return error(message: 'Member is not found.')

    end

  end

end




if ENV['ENABLE_ELATION'] == true

    do_something_related_to_elation

  else

    do_nothing

end


$rollout.activate(:enable_elation)

$rollout.deactivate(:enable_elation)

 
