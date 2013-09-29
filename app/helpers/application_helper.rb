module ApplicationHelper
  PAGE_NAME = 'CodeCrowd'

  def yield_title_or_default
    if page_title.present?
      page_title
    else
      PAGE_NAME
    end
  end
end
