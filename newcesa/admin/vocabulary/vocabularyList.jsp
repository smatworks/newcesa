<%
	/*============================================================================
	 * @ Description : 관리자 리스트
	 *
	 * 작성일 : 2011.04.18
	 * 작성자 : 이정순
	 ============================================================================*/
%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ include file="/include/header.jsp" %>
<%@ include file="/include/headerAdmin.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/dnt7-com.tld" prefix="dnt7" %>
<%
	m1 = 2;
	m2 = 1;
	m3 = 1;
%>
<%@ include file="/admin/include/menu.jsp" %>
<%
    // Params
	int currPage = Integer.parseInt(StringUtils.defaultString(request.getParameter("_currPage"),  "1"));
	String groupSeq = StringUtils.defaultString(request.getParameter("groupSeq"),  "");


	// Vars
	int totalCount = 0;
	RowSetMapper cRowSet = null;

	
	//그룹 select	1000으로 셋팅
	StringBuffer sbufSelect = new StringBuffer();
	cRowSet = GroupDAO.getInstance().groupList(1000, 1);
	sbufSelect.append("<select name='groupSeq'>");
	sbufSelect.append("<option value=''>전체</option>");
	while(cRowSet.next()){
		if(groupSeq.equals(cRowSet.getString("seq"))){
			sbufSelect.append("<option value='"+cRowSet.getString("seq")+"' selected>"+cRowSet.getString("group_name")+"</option>");
		}
		else{
			sbufSelect.append("<option value='"+cRowSet.getString("seq")+"'>"+cRowSet.getString("group_name")+"</option>");
		}
	}
	sbufSelect.append("</select>");

	if(!sGroup.equals("0")){
		groupSeq = sGroup;
	}


	cRowSet = VocabularyDAO.getInstance().getVocabularyList(groupSeq);
	
	int num = 0;

%>
<script type="text/javascript">
function goSearch(){
	var frm = document.actFrm;

	frm.submit();
}

function goDelete(seq)
{
	if(confirm("삭제하시겠습니까?")){
		location.href = "vocabularyProc.jsp?mode=Delete&seq="+seq;
	}
}
</script>
<div class="top_title">어휘 관리</div>
<div id="search_form_inline" style="clear:both;">
<form name="actFrm" action="vocabularyList.jsp">
<%
	if(sGroup.equals("0")){
%>
	<div id="search_form_inline_in">
		Group : <%=sbufSelect%>
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="Search" style="width:50px;" onclick='goSearch();' class="button white btn_in" />
	</div>
<%
	}			
%>
</form>
</div>

<div id="roof_table">
	<table cellspacing="0" cellpadding="0" width="900px">
		<colgroup>
			<col width="40px" />
			<col />
			<col width="220px"/>
			<col width="140px" />
		</colgroup>
		<thead>
		<tr>
			<th class="ta_c">No.</th>
			<th class="ta_c">경험어휘</th>
			<th class="ta_c">그룹</th>
			<th class="ta_c">수정 / 삭제</th>
		</tr>
		</thead>
		<tbody>
		<%
		try{
			while(cRowSet.next()){
		%>
		<tr>
			<td class="ta_c"><%=++num%></td>
			<td class="ta_c"><a href="vocabularyForm.jsp?seq=<%=cRowSet.getString("seq")%>"><%=cRowSet.getString("word")%></a></td>
			<td class="ta_c"><a href="vocabularyForm.jsp?seq=<%=cRowSet.getString("seq")%>"><%=cRowSet.getString("group_name")%></a></td>
			<td class="ta_c"><a href="vocabularyForm.jsp?seq=<%=cRowSet.getString("seq")%>">수정</a> / <a href="javascript:goDelete('<%=cRowSet.getString("seq")%>')">삭제</a></td>
		</tr>
		<%
			}
		}
		catch(Exception e){
			log.debug(e);	
		}

		if(num == 0){
		%>
		<tr>
			<td colspan="4" class="ta_c">등록된 어휘가 없습니다.</td>
		</tr>
		<%
		}
		%>
		</tbody>
	</table>
</div>

<div class="btn_group_right_align">
	<input type="button" onclick="document.location.href='vocabularyForm.jsp'" value="Add" class="button white" style="width:33px;"/>
</div>

<%@ include file="/include/footerAdmin.jsp" %>
<%@ include file="/include/footer.jsp" %>
