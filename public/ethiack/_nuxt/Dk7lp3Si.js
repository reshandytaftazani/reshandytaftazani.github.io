import{g as r}from"./D78AaF3G.js";function p(){return r`
    {
			"slug": slug.current,
			title,
			keywords,
			...*[_type == 'settings'][0].metadata{
				sitename,
				"sitedescription": description,
				"description": coalesce(^.description, description),
				"image": coalesce(^.image, preview).asset->.url
			},
			"organization": *[_type == 'settings'][0].organizationSchema,
    }
  `}function l(o){const s=t=>t.replace(/[-_\s]+(.)?/g,(i,e)=>e?e.toUpperCase():"").replace(/^(.)/,i=>i.toLowerCase());return{getSection:(t,{matchTitle:i=!1}={})=>{const e=o.sections?.find(n=>i&&n.internalTitle&&s(n.internalTitle)===t||n._type==t);return e&&(e.consoleSnippet?.code?{...e,"data-console-snippet":JSON.stringify(e.consoleSnippet)}:e)}}}export{p as m,l as u};
//# sourceMappingURL=Dk7lp3Si.js.map
