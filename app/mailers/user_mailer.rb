class UserMailer < ApplicationMailer
  default from: "from@example.com"
  def send_email(id)
    mail(to: 'prakashpoudel@lftechnology.com',subject: "Product of #{id} has been created") do |format|
      format.text{render text: "Product of id:#{id} has been created"}
    end
  end
end
