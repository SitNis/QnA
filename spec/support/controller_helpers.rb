module ControllerHelpers
	def login(user)
		@request.env['devise.mapping'] = Devise.mappings[:user]
		sign_in(user)
	end

	def show_question_after_delete(answer)
		delete :destroy, params: { id: answer }
		expect(response).to redirect_to answer.question
	end
end
