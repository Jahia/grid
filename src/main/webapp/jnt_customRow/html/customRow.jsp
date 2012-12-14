<%@ include file="../../common/declarations.jspf" %>
<jsp:useBean id="colMap" class="java.util.LinkedHashMap"/>
<template:addResources type="css" resources="960.css"/>
<template:addResources type="javascript" resources="jquery.min.js"/>

<jcr:nodeProperty node="${currentNode}" name="customColumn" var="customColumn"/>
<c:set var="nbCols" value="0"/>
<c:set var="nbArea" value="0"/>

<c:forTokens items="${customColumn.string}" delims="," varStatus="vs" var="col">
    <c:set target="${colMap}" property="col${vs.count}" value="${col}"/>
    <c:if test="${fn:contains(col,' ')}">
        <c:forTokens items="${col}" delims=" " varStatus="vs" var="c">
            <c:if test="${vs.count eq 1}">
                <c:set var="col" value="${c}"/>
            </c:if>
        </c:forTokens>
    </c:if>
    <c:set var="nbCols" value="${nbCols + col}"/>
    <c:set var="nbAreas" value="${nbAreas + 1}"/>
</c:forTokens>
<c:set var="nbNames" value="0"/>
<c:forTokens items="${currentNode.properties.colNames.string}" delims="," varStatus="vs">

    <c:set var="nbNames" value="${nbNames + 1}"/>
</c:forTokens>

<c:if test="${!empty currentNode.properties.divID}"> <div id="${currentNode.properties.divID.string}"></c:if>
   <div <c:if test="${renderContext.editModeConfigName eq 'studiolayoutmode'}">
                    style="background-color: #FFFFFF;background-image: url('${url.currentModule}/img/960_16_10_10.png');background-repeat: repeat-y;"
                </c:if>
    class="container_16" id="container_16_${fn:replace(currentNode.identifier,'-','_')}">
    <c:if test="${!empty currentNode.properties.divClass}">
    <div class="${currentNode.properties.divClass.string}"></c:if>

        <c:if test="${renderContext.editModeConfigName eq 'studiolayoutmode'}">
            <div class="grid_${nbCols}">${jcr:label(currentNode.primaryNodeType,currentResource.locale)} ${currentNode.name}: ${customColumn.string}
                <c:if test="${nbNames != nbAreas}">
                    <p><fmt:message key="label.generatedNames"/></p>
                </c:if>
            </div>
        </c:if>
        <c:set var="colNames" value="${fn:split(currentNode.properties.colNames.string, ',')}"/>

        <c:forEach items="${colMap}" var="col" varStatus="count">
            <c:set var="column" value="${col.value}"/>
            <c:set var="colCss" value=""/>
            <c:if test="${fn:contains(column,' ')}">
                <c:forTokens items="${column}" delims=" " varStatus="vs" var="c">
                    <c:if test="${vs.count eq 1}">
                        <c:set var="column" value="${c}"/>
                    </c:if>
                    <c:if test="${!(vs.count eq 1)}">
                        <c:set var="colCss" value="${colCss} ${c}"/>
                    </c:if>
                </c:forTokens>
            </c:if>
            <!--start grid_${column}-->
            <div class='grid_${column} ${colCss} grid_${fn:replace(currentNode.identifier,'-','_')}'
                 id='grid_${fn:replace(currentNode.identifier,'-','_')}_${count.count}' style="position:relative;">
                <c:if test="${renderContext.editModeConfigName eq 'studiolayoutmode'}">
                <div style="border: 1px dashed #999; padding: 5px">
                    <span>Size : ${column}</span>
                    </c:if>
                    <c:if test="${nbNames == nbAreas}">
                        <c:forTokens items="${currentNode.properties.colNames.string}" var="colName" delims=","
                                     varStatus="vs1">
                            <c:if test="${count.count == vs1.count}">
                                <template:area path="${colName}" areaAsSubNode="true"/>
                            </c:if>
                        </c:forTokens>
                    </c:if>
                    <c:if test="${nbNames != nbAreas}">
                        <template:area path="${currentNode.name}-${col.key}" areaAsSubNode="true"/>
                    </c:if>
                    <c:if test="${pageScope['org.jahia.emptyArea']}">
                        &nbsp;&nbsp;
                    </c:if>
                    <c:if test="${renderContext.editModeConfigName eq 'studiolayoutmode'}">
                </div>
                </c:if>
                <div class='clear'></div>
            </div>

            <!--stop grid_${column}-->
        </c:forEach>
        <div class='clear'></div>
        <c:if test="${!empty currentNode.properties.divClass}"></div>
    </c:if>
</div>
<c:if test="${!empty currentNode.properties.divID}"></div></c:if>

<script type="text/javascript">

    function postRow${fn:replace(currentNode.identifier,'-','_')}(val) {
        $.post("<c:url value='${url.base}${functions:escapePath(currentNode.path)}'/>", {"jcrMethodToCall":"put","customColumn":val},
                function (result) {
                    location.reload();
                },
                'json'
        );
    }

    $(document).ready(function () {
        <%--maxHeight = 0;--%>
        <%--$('.grid_${fn:replace(currentNode.identifier,'-','_')}').each(function () {--%>
            <%--totalHeight = 0;--%>
            <%--$('#' + $(this).attr('id') + ' .studiolayoutmodearea').each(function () {--%>
                <%--totalHeight += $(this).height();--%>
            <%--})--%>
            <%--maxHeight = totalHeight > maxHeight ? totalHeight : maxHeight--%>
        <%--})--%>

        <%--$('.grid_${fn:replace(currentNode.identifier,'-','_')}').each(function () {--%>
            <%--num = $('#' + $(this).attr('id') + ' .studiolayoutmodearea').size();--%>
            <%--$('#' + $(this).attr('id') + ' .studiolayoutmodearea').each(function () {--%>
                <%--$(this).height(maxHeight / num);--%>
            <%--})--%>
        <%--});--%>

        <%--maxHeight = 0;--%>
        <%--$('.grid_${fn:replace(currentNode.identifier,'-','_')} > div').each(function () {--%>
            <%--maxHeight = $(this).height() > maxHeight ? $(this).height() : maxHeight--%>
        <%--})--%>
        <%--$('.grid_${fn:replace(currentNode.identifier,'-','_')} > div').each(function () {--%>
            <%--$(this).height(maxHeight)--%>
        <%--})--%>

        <c:if test="${renderContext.editModeConfigName eq 'studiolayoutmode'}">
        <c:forEach items="${colMap}" var="col" varStatus="count">
        <c:if test="${not count.last}">
        cont = $('#grid_${fn:replace(currentNode.identifier,'-','_')}_${count.count}')

                <c:set var="left" value=""/>
                <c:forEach items="${colMap}" var="col2" varStatus="count2">
                    <c:choose>
                    <c:when test="${count2.count == count.count}"><c:set var="left" value="${left}${fn:trim(col2.value)-1}"/></c:when>
                    <c:when test="${count2.count == count.count+1}"><c:set var="left" value="${left}${fn:trim(col2.value)+1}"/></c:when>
                    <c:otherwise><c:set var="left" value="${left}${fn:trim(col2.value)}"/></c:otherwise>
                    </c:choose>
                <c:if test="${not count2.last}"><c:set var="left" value="${left},"/></c:if>
                </c:forEach>
                <c:set var="right" value=""/>
                <c:forEach items="${colMap}" var="col2" varStatus="count2">
                    <c:choose>
                    <c:when test="${count2.count == count.count}"><c:set var="right" value="${right}${fn:trim(col2.value)+1}"/></c:when>
                    <c:when test="${count2.count == count.count+1}"><c:set var="right" value="${right}${fn:trim(col2.value)-1}"/></c:when>
                    <c:otherwise><c:set var="right" value="${right}${fn:trim(col2.value)}"/></c:otherwise>
                    </c:choose>
                <c:if test="${not count2.last}"><c:set var="right" value="${right},"/></c:if>
                </c:forEach>


        $('#grid_${fn:replace(currentNode.identifier,'-','_')}_${count.count}').append($('<div class="grid_${fn:replace(currentNode.identifier,'-','_')}_resizer" style="cursor:pointer; width: 16px; height:32px; position: absolute; left: ' + (cont.width()) + 'px; top: ' + ((cont.height() / 2)-16) + 'px;">' +
                '<img onclick="postRow${fn:replace(currentNode.identifier,'-','_')}(\'${left}\')" src="${url.currentModule}/img/navigate_left.png"/>' +
                '<img onclick="postRow${fn:replace(currentNode.identifier,'-','_')}(\'${right}\')" src="${url.currentModule}/img/navigate_right.png""/>' +
                '</div>'))
        </c:if>
        </c:forEach>
        </c:if>

    });
</script>