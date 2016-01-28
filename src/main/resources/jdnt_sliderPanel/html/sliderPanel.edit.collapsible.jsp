<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="s" uri="http://www.jahia.org/tags/search" %>
<%-- TODO: live/preview only offer light/dark theme options, not colors as stated here. editSlider.css needs to update to match --%>
<%-- TODO: edit mode is tiling smaller photos, but live/preview stretches, need to update edit mode --%>
<%-- TODO: overlay image is a white boxed background, not transparent --%>
<%-- TODO: update tab naming to be unique --%>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>

<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>
<c:set var="subtitle" value="${currentNode.properties.subtitle.string}"/>
<c:set var="summary" value="${currentNode.properties.body.string}"/>
<c:set var="textColor" value="${currentNode.properties.textColor.string}"/>
<c:set var="link" value="${currentNode.properties.internalLink.node}"/>
<c:set var="linkText" value="${currentNode.properties.linkText.string}"/>
<c:set var="background" value="${currentNode.properties.backgroundImg.node}"/>
<c:set var="image" value="${currentNode.properties.smallPhoto.node}"/>

<%-- If a color theme was not selected use light --%>
<c:if test="${empty textColor}"><c:set var="textColor" value="light"/></c:if>

<%-- if linkText is not filled in use default Read More from resource file--%>
<c:if test="${empty linkText}">
    <c:set var="linkText"><fmt:message key="jdnt_sliderPanel.readMore"/></c:set>
</c:if>

<%-- get the background image, if none provided use default background.jpg image --%>
<c:choose>
    <c:when test="${empty background}">
        <c:url var="backgroundUrl" value="${url.currentModule}/img/background.jpg"/>
    </c:when>
    <c:otherwise>
        <c:url var="backgroundUrl" value="${background.url}"/>
    </c:otherwise>
</c:choose>

<%-- get pixel layout for text and image --%>
<%-- TODO: edit this as necessary for best layout options or update to be a parameter --%>
<c:set var="layout" value="${currentNode.properties.layout.string}"/>

<c:if test="${layout == 'right'}">
    <c:set var="textLayout" value="-right"/>
</c:if>

<div class="panel panel-default">
    <div class="panel-heading">
        <h4 class="panel-title">
            <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-1" href="#collapse-${currentNode.identifier}">
                ${title}
            </a>
        </h4>
    </div>
    <div id="collapse-${currentNode.identifier}" class="panel-collapse collapse">
        <div class="panel-body">
            <div class="row">


<div id="slidertab-${currentNode.identifier}" class="tab-content tab-selector-${currentNode.parent.identifier}"
     style="background: url('${backgroundUrl}')">
    <div class="edit-slider-cont${textLayout}">

        <c:if test="${not empty subtitle}">
            <c:choose>
                <c:when test="${textColor eq 'dark'}"> <div class="first-layer-editslider color-dark">${subtitle}</div></c:when>
                <c:otherwise><div class="first-layer-editslider">${subtitle}</div></c:otherwise>
            </c:choose>
        </c:if>
        <c:if test="${not empty title}"><div class="second-layer-editslider">
            <%--TODO: Subtitle should always be color-green --%>
        <span class="color-green">${title}</span>
        </div></c:if>

        <c:if test="${not empty summary}">
            <c:choose>
                <c:when test="${textColor eq 'dark'}"> <div class="text-layer-editslider color-dark">${summary}</div></c:when>
                <c:otherwise><div class="text-layer-editslider">${summary}</div></c:otherwise>
            </c:choose>
        </c:if>

        <c:if test="${not empty link}">
        <a class="but-layer-editslider" href="${link.url}" alt="${title}">${linkText}</a>
</c:if>
    </div>
    <%-- second image if exists --%>
    <c:if test="${not empty image}">
    <img class="ms-img-bordered edit-slider-img" src="${image.url}" alt="">
</c:if>
</div>


            </div>
        </div>
    </div>
</div>