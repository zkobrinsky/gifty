module SessionsHelper
    def show_time(card)
        card.created_at.localtime.strftime('%b %e,%l:%M %p')
    end

    def username_or_email(user)
        user.username ? user.username : user.email
    end
end
