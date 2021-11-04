class AttachmentsController < ActionController::Base
	def purge
		attachment = ActiveStorage::Attachment.find(params[:id])
		attachment.purge
		redirect_back fallback_location: @article_path, notice: "Attachment deleted"
	end
end
