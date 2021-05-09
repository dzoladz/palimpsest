#### EBSCO
- Article Search
```
<form action="javascript:submitArticleDatabasesSearch();">
	<label for="searchbox">Search for:</label>
	<input name="article_searchbox" type="text" placeholder="Enter Keywords">
	<span class="search-in">
		<label for="database" class="libdata in">in</label>
		<select name="database">
			<option disabled="disabled" value="">Choose a Database</option>
			<option value="a9h">Academic Search Complete</option>
			<option value="jstor">JSTOR</option>
		</select>
	</span>
	<input name="article_search_submit" type="submit" value="Search">
</form>

<script>
function submitArticleDatabasesSearch() {
	const proxyPrefix = "https://YOUREZPROXYDOMAINHERE/login?url=";
	var selected = document.getElementsByName('database')[0].value;
	var terms = document.getElementsByName('article_searchbox')[0].value;

	if (selected != "") {
		console.log("Okay");
		if (selected == "a9h") {
			console.log("User selected: " + selected);
			const ebscoPrefix = "https://search.ebscohost.com/login.aspx?direct=true&scope=site&type=1&site=ehost-live&db=a9h&lang=en&authtype=cookie,ip&ssl=Y&&bquery="
			window.location.assign(proxyPrefix + ebscoPrefix + terms)
		} else if (selected == "jstor") {
			console.log("User selected: " + selected);
			const jstorPrefix = "https://www.jstor.org/action/doAdvancedSearch?q0="
			window.location.assign(proxyPrefix + jstorPrefix + terms)
		} else {
			console.log("Unexpected value for select option")
		}
	} else {
		return false;
	}
}
</script>
```

- OneSearch
```
<form action="javascript:submitOneSearch()">

	<select id="search-field" name="search_prefix">
		<option selected="selected" value="">Keyword</option>
		<option value="TI">Title</option>
		<option value="AU">Author</option>
	</select>

	<input name="bquery" type="text" placeholder="Enter keywords" value="">
	<input type="submit" value="Search"><br>
	<input id="fulltext_checkbox_all" name="fulltext_checkbox" type="checkbox" class="check">
	<label for="fulltext_checkbox_all">Full-Text (online)</label>
	<input id="scholarly_checkbox_articles" name="scholarly_checkbox" type="checkbox" class="check">
	<label for="scholarly_checkbox_articles">Scholarly (Peer Reviewed)</label>
</form>

<script>
	function submitOneSearch() {
		const proxyPrefix = "https://YOUREZPROXYDOMAINHERE/login?url=";
		const edsProfile = "http://search.ebscohost.com/login.aspx?direct=true&scope=site&site=edslive&profile=eds&authtype=ip,cookie,guest,url,uid&custid=s9003022&groupid=main&";
		var search_field = document.getElementsByName('search_prefix')[0].value;
		var limit_ft = document.getElementsByName('fulltext_checkbox')[0].checked;
		var limit_rv = document.getElementsByName('scholarly_checkbox')[0].checked;
		var search_terms = document.getElementsByName('bquery')[0].value;

		// Toggle Full-Text Limiter
		if (limit_ft == true) {
			console.log("Enable FT Limiter");
			ft = "cli0=FT&clv0=Y";
		} else {
			console.log("Disable FT Limiter")
			ft = "cli0=FT&clv0=N";
		}

		// Toggle Scholarly Atricles Limiter
		if (limit_rv == true) {
			console.log("Enable RV Limiter");
			rv = "cli1=RV&clv1=Y";
		} else {
			console.log("Disable RV Limiter");
			rv = "cli1=RV&clv1=N";
		}

		// Build Search Type
		if (search_field != "") {
			type = "search_field=" + search_field
		} else {
			type = "search_field="
		}

		window.location.assign(proxyPrefix + edsProfile + type + "&" + ft + "&" + rv + "&bquery=" + search_terms)

	}
</script>
```

