module CommentsHelper
    def nested_comments(comments)
        comments.map do |comment|
            content_tag(:div, render(comment), class: (comment.depth < 4 ? "comment-box-#{comment.depth}" : "comment-box-3"))
        end.join.html_safe
    end

    def comment_name(comment)
        if comment.discarded? or comment.user.nil?
            "[deleted]"
        else
            "#{comment.user.first_name} #{comment.user.last_name}"
        end
    end

    def comment_content(comment)
        comment.discarded? ? "[deleted]" : comment.content
    end
end
