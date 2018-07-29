module CommentsHelper
    def nested_comments(comments)
        comments.map do |comment|
            content_tag(:div, render(comment), class: (comment.depth < 4 ? "comment-box-#{comment.depth}" : "comment-box-3"))
        end.join.html_safe
    end

    def nested_comments_reply(parent_comment)
        parent_comment.path.map do |comment|
            content_tag(:div, render(comment), class: (comment.depth < 4 ? "comment-box-#{comment.depth}" : "comment-box-3"))
        end.join.html_safe
    end
end
