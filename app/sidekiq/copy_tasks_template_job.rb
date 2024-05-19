class CopyTasksTemplateJob
  include Sidekiq::Job

  sidekiq_options retry: false

  # TODO: break this out into a service
  def perform(destination)
    task_document_file = TemplateDuplicator.copy(template_name: 'DD-MM-YY - Tasks', destination:)
    DiscussionSessionManager.session_for_this_fortnight.set_task_document(
      link: task_document_file.web_view_link
    )
    notify_done
  end

  private

  def notify_done
    message = TemplateEngine.generate(:start_preparation)
    DiscordNotifier.send_message(
      Rails.application.credentials.dig(:discord, :message_channel_id),
      message
    )
  end
end
