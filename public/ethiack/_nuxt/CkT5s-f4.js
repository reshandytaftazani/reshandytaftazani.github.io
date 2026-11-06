import{g as t,aP as n}from"./Bodbplh8.js";function e(){return t`{
		quote,
		author-> {
			name,
			role,
			company,
			photo {...${n()}}
		}
	}`}function o(){return t`testimonials[]-> ${e()}`}function i(){return t`*[_type == "communityQuote"] ${e()}`}function s(){return t`select(count(testimonials) > 0 => ${o()}, ${i()})`}function u(){return t`
 *[_type == 'sharedContent'][0] {
   ...community {
     titleWithSnippet,
     "testimonials": ${s()},
     consoleSnippet
   },
}
`}export{u as c};
//# sourceMappingURL=CkT5s-f4.js.map
