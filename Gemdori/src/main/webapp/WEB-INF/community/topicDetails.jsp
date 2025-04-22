<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Header Include -->

<!-- Community Details Section Begin -->
<section class="community-details spad">
    <div class="container">
        <div class="row d-flex justify-content-center">
            <div class="col-lg-8">
                <div class="community__details__title">
                    <h6>${topic.topicTitle} <span>- ${topic.writeDate}</span></h6>
                    <h2>${topic.topicContents}</h2>
                </div>
            </div>
            <div class="col-lg-8">
                <div class="community__details__content">
                    <div class="community__details__text">
                        <p>${post.content}</p>
                    </div>

                    <!-- Comments Section (Optional) -->
                    <div class="community__details__comment">
                        <h4>${comments.size()} Comments</h4>
                        <c:forEach var="comment" items="${comments}">
                            <div class="community__details__comment__item">
                                <div class="community__details__comment__item__pic">
                                    <img src="${comment.authorImage}" alt="Commenter Image">
                                </div>
                                <div class="community__details__comment__item__text">
                                    <span>${comment.date}</span>
                                    <h5>${comment.author}</h5>
                                    <p>${comment.text}</p>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- Comment Form (Optional) -->
                    <div class="community__details__form">
                        <h4>Leave A Comment</h4>
                        <form action="#" method="post">
                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-6">
                                    <input type="text" name="author" placeholder="Name">
                                </div>
                                <div class="col-lg-12">
                                    <textarea name="comment" placeholder="Message"></textarea>
                                    <button type="submit" class="site-btn">Send Message</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- topic Details Section End -->

