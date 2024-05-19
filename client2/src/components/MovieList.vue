<template>
	<div>
	  <h2>All Movies</h2>
	  <div>
		<label>Sort by Rating:</label>
		<button @click="sortMovies('asc')">Ascending</button>
		<button @click="sortMovies('desc')">Descending</button>
	  </div>
	  <div>
		<label>Group by:</label>
		<button @click="groupBy('author')">Author</button>
		<button @click="groupBy('tag')">Tag</button>
	  </div>
	  <div v-for="group in groupedMovies" :key="group.name">
		<h3>{{ group.name }}</h3>
		<ul>
		  <li v-for="movie in group.movies" :key="movie.id">
			{{ movie.title }} - Rating: {{ movie.rate }}
		  </li>
		</ul>
	  </div>
	</div>
  </template>
  
  <script>
  import { getFilms, getAuthors, getTags } from '../services/api';
  
  export default {
	data() {
	  return {
		movies: [],
		authors: [],
		tags: [],
		sortOrder: 'asc',
		groupByType: ''
	  };
	},
	computed: {
	  sortedMovies() {
		return this.movies.sort((a, b) => {
		  if (this.sortOrder === 'asc') {
			return a.rate - b.rate;
		  }
		  return b.rate - a.rate;
		});
	  },
	  groupedMovies() {
		if (this.groupByType === 'author') {
		  return this.groupByAuthor();
		}
		if (this.groupByType === 'tag') {
		  return this.groupByTag();
		}
		return [{ name: 'All Movies', movies: this.sortedMovies }];
	  }
	},
	methods: {
	  async fetchMovies() {
		try {
		  const [moviesResponse, authorsResponse, tagsResponse] = await Promise.all([getFilms(), getAuthors(), getTags()]);
		  this.movies = moviesResponse.data;
		  this.authors = authorsResponse.data;
		  this.tags = tagsResponse.data;
		} catch (error) {
		  console.error(error);
		}
	  },
	  sortMovies(order) {
		this.sortOrder = order;
	  },
	  groupBy(type) {
		this.groupByType = type;
	  },
	  groupByAuthor() {
		return this.authors.map(author => ({
		  name: author.name,
		  movies: this.sortedMovies.filter(movie => movie.author_id === author.id)
		}));
	  },
	  groupByTag() {
		console.log(this.sortedMovies);
		return this.tags.map(tag => ({
		  name: tag.name,
		  movies: this.sortedMovies.filter(movie => movie.tags.some(t => t.name === tag.name))
		}));
	  }
	},
	mounted() {
	  this.fetchMovies();
	}
  };
  </script>
  