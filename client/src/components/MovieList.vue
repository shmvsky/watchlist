<template>
	<div class="">	
	  <div class="d-flex flex-row gap-4 mb-3">
			<div class="border rounded p-2 d-flex flex-row align-items-center">
				<label class="">Рейтинг</label>
				<button class="btn btn-primary-secondary" @click="sortMovies('asc')"><fa icon="arrow-up"/></button>
				<button class="btn btn-primary-secondary" @click="sortMovies('desc')"><fa icon="arrow-down"/></button>
			</div>
			<div class="border rounded p-2 d-flex flex-row align-items-center">
				<label class="">Группировать</label>
				<button class="btn btn-primary-secondary" @click="groupBy('author')"><fa icon="user"/></button>
				<button class="btn btn-primary-secondary" @click="groupBy('tag')"><fa icon="tag"/></button>
				<button class="btn btn-primary-secondary" @click="groupBy('default')"><fa icon="x"/></button>
			</div>
	  </div>

	  <div v-for="group in groupedMovies" class="mt-3" :key="group.name">
			<span class="display-6 text-decoration-underline">{{ group.name }}</span>
			<div class="d-flex flex-wrap gap-2 mt-2">
				<div v-for="movie in group.movies" :key="movie.id" class="card" style="width: 18rem;">
					<div class="card-body">
						<h5 class="card-title">{{ movie.title }}</h5>
						<p class="card-text">{{ movie.note }}</p>
						<span class="card-link badge bg-danger" @click="deleteMovie(movie.id)"><fa icon="trash"/></span>
						<span class="card-link badge bg-dark">{{ movie.status }}</span>
						<span class="card-link badge bg-dark">{{ movie.rate }}</span>
					</div>
				</div>
			</div>
	  </div>

	</div>
</template>
  
  <script>
  import { getFilms, getAuthors, getTags, deleteFilm } from '../services/api';
  
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
		return [{name: "Все фильмы", movies: this.sortedMovies }];
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
	  async deleteMovie(movie_id) {
		try {
			const [delResponse] = await Promise.all([deleteFilm(movie_id)]);
			if (delResponse.status === 204) {
				this.fetchMovies();
			}
		} catch {
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
		})).filter(g => g.movies.length);
	  },
	  groupByTag() {
		console.log(this.sortedMovies);
		return this.tags.map(tag => ({
		  name: tag.name,
		  movies: this.sortedMovies.filter(movie => movie.tags.some(t => t.name === tag.name))
		})).filter(g => g.movies.length);
	  }
	},
	mounted() {
	  this.fetchMovies();
	}
  };
  </script>
  