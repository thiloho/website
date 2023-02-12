import { defineCollection, z } from 'astro:content';

const articles = defineCollection({
	schema: z.object({
		title: z.string(),
		description: z.string(),
		publicationDate: z.date(),
	}),
});

export const collections = { articles };