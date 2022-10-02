module UserHelper
    def gravatar_for(user, size: 80)
        
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        gravatar_url ="https://s.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        image_tag(gravatar_url, alt: user.name, class: "gravatar" )
    end
end
#hellep giong kieu middle ware hay la kieu dinh nghia 1 ham r goi o hoac view