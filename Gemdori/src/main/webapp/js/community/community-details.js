// 댓글 폼 검증
document.querySelector("form").addEventListener("submit", function(event) {
    var author = document.querySelector("input[name='author']").value;
    var email = document.querySelector("input[name='email']").value;
    var comment = document.querySelector("textarea[name='comment']").value;

    if (!author || !email || !comment) {
        alert("모든 필드를 채워주세요.");
        event.preventDefault();  // 폼 제출을 막음
    } else {
        alert("댓글이 성공적으로 제출되었습니다.");
    }
});

// 좋아요 버튼 동작 (예시)
document.querySelectorAll('.like-btn').forEach(function(button) {
    button.addEventListener("click", function() {
        var likesCount = this.querySelector('.likes-count');
        likesCount.textContent = parseInt(likesCount.textContent) + 1;
    });
});
