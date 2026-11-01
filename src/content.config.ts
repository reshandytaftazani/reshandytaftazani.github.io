import { defineCollection, z } from 'astro:content';
import { glob } from 'astro/loaders';

const projects = defineCollection({
  loader: glob({ pattern: "**/*.md", base: "./src/content/projects" }),
  schema: z.object({
    title: z.string(),
    subtitle: z.string(),
    category: z.string(),
    status: z.string(),
    timeline: z.string(),
    role: z.string(),
    techStack: z.array(z.string()),
    metrics: z.array(
      z.object({
        label: z.string(),
        value: z.string(),
        detail: z.string(),
      })
    ),
    githubUrl: z.string(),
    runCommand: z.string(),
    featured: z.boolean().default(false),
  }),
});

export const collections = { projects };
