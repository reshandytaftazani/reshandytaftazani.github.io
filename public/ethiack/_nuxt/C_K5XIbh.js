import{A as l,b2 as c,b3 as f,aP as y,b4 as m,g as p,b5 as g,b6 as i,b7 as b,F as h}from"./D78AaF3G.js";const $=()=>l().$device;function v(){const n=$().isDesktop?.1:1;return{registerHydration:(r,s,t=!1)=>{setTimeout(()=>{if(r.value=!0,t){const a=typeof t=="string"?` (${t})`:""}},s*n)},factor:n}}function k(){return p`
 *[_type == 'sharedContent'][0] {
   ...footer {
     title,
     buttonCtaList[]{${c()}},
     secondaryPages[]{${f()}},
     support {
       logo {...${y()}},
       "link": {
         "to": link[0]{
           "type": _type,
           "url": url,
           "slug": select(
             ^.link[0]->._type == 'page.landing' => '',
             ^.link[0]->metadata.slug.current
           ),
           "document": ^.link[0]->._type,
         }
       }
     },
     compliant,
     "snippets": snippets[].code,
     consoleSnippet
   },
   ...${m()}
},
`}function T(e){return p`*[_type == "sharedContent"][0].preFooters[("${e}" in pageTypes)][0] {
     title,
     description,
     buttonCtaList[]{${c()}},
     barsVariant,
     functionSnippet,
     consoleSnippet
}`}function A(e,n){return(o,r)=>g({inheritAttrs:!1,props:e,emits:["hydrated"],setup(s,t){const a=i({loader:r}),d=i({hydrate:n(s),loader:()=>Promise.resolve(a)}),u=()=>{t.emit("hydrated")};return()=>b(d,h(t.attrs,{onVnodeMounted:u}),t.slots)}})}const H=A({hydrateAfter:{type:Number,required:!0}},e=>e.hydrateAfter===0?void 0:n=>{const o=setTimeout(n,e.hydrateAfter);return()=>clearTimeout(o)});export{H as c,k as f,T as p,v as u};
//# sourceMappingURL=C_K5XIbh.js.map
