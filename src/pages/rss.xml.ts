import rss from '@astrojs/rss';
import { getCollection } from 'astro:content';
import type { APIContext } from 'astro';

export async function GET(context: APIContext) {
  const notes = await getCollection('notes');
  const siteUrl = (context.site ? context.site.toString() : 'https://reshandytaftazani.github.io').replace(/\/$/, '');
  
  // Sort descending by publication date
  const sortedNotes = [...notes].sort(
    (a, b) => new Date(b.data.publishedAt).getTime() - new Date(a.data.publishedAt).getTime()
  );

  return rss({
    title: 'Reshandy Taftazani — Technical Field Notes & Engineering Journal',
    description: 'Engineering dispatches on distributed inference runtimes, defensive temporal verification, zero-leakage feature stores, and robust systems architecture by Reshandy Taftazani.',
    site: siteUrl,
    items: sortedNotes.map((note) => ({
      title: note.data.title,
      pubDate: new Date(note.data.publishedAt),
      description: `${note.data.subtitle} — ${note.data.abstract}`,
      link: `/notes/${note.id}/`,
      categories: [note.data.category],
      author: 'reshandy.taftazani@ui.ac.id (Reshandy Taftazani Aulya)',
    })),
    customData: `<language>en-us</language><atom:link href="${siteUrl}/rss.xml" rel="self" type="application/rss+xml"/>`,
    xmlns: {
      atom: 'http://www.w3.org/2005/Atom',
    },
  });
}
