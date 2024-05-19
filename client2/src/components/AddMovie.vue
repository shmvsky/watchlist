<template>
	<div>
	  <h2>Add New Movie</h2>
	  <form @submit.prevent="submitForm">
		<div>
		  <label>Title:</label>
		  <input v-model="film.title" required>
		</div>
		<div>
		  <label>Note:</label>
		  <textarea v-model="film.note"></textarea>
		</div>
		<div>
		  <label>Rate:</label>
		  <input type="number" v-model="film.rate" min="1" max="5">
		</div>
		<div>
		  <label>Status:</label>
		  <select v-model="film.status">
			<option value=0>Watched</option>
			<option value=1>Planned</option>
			<option value=2>Dropped</option>
		  </select>
		</div>
		<div>
		  <label>Author:</label>
		  <select v-model="film.author_id">
			<option v-for="author in authors" :value="author.id">{{ author.name }}</option>
		  </select>
		  <input v-model="newAuthorName" placeholder="Add new author">
		  <button type="button" @click="addNewAuthor">Add Author</button>
		</div>
		<div>
		  <label>Tags:</label>
		  <select v-model="selectedTag">
			<option v-for="tag in tags" :value="tag.id">{{ tag.name }}</option>
		  </select>
		  <button type="button" @click="addTag">Add Tag</button>
		  <ul>
			<li v-for="tag in film.tags">{{ tag.name }}</li>
		  </ul>
		</div>
		<div>
		  <button type="submit">Add Movie</button>
		</div>
	  </form>
	</div>
  </template>
  
  <script>
  import { getAuthors, createAuthor, getTags, createFilm } from '../services/api';
  
  export default {
	data() {
	  return {
		film: {
		  title: '',
		  note: '',
		  rate: null,
		  status: 0,
		  author_id: null,
		  tags: []
		},
		authors: [],
		tags: [],
		newAuthorName: '',
		selectedTag: null
	  };
	},
	methods: {
	  async fetchAuthorsAndTags() {
		try {
		  const [authorsResponse, tagsResponse] = await Promise.all([getAuthors(), getTags()]);
		  console.log(authorsResponse);
		  this.authors = authorsResponse.data;
		  this.tags = tagsResponse.data;
		} catch (error) {
		  console.error(error);
		}
	  },
	  async addNewAuthor() {
		try {
		  const response = await createAuthor({ name: this.newAuthorName });
		  this.authors.push(response.data);
		  this.film.author_id = response.data.id;
		  this.newAuthorName = '';
		} catch (error) {
		  console.error(error);
		}
	  },
	  addTag() {
		const tag = this.tags.find(tag => tag.id === this.selectedTag);
		if (tag && !this.film.tags.includes(tag)) {
		  this.film.tags.push(tag);
		}
	  },
	  async submitForm() {
		try {
		  this.film.status = parseInt(this.film.status);
		  await createFilm(this.film);
		  alert('Movie added successfully');
		  this.$router.push('/movies');
		} catch (error) {
		  console.error(error);
		}
	  }
	},
	mounted() {
	  this.fetchAuthorsAndTags();
	}
  };
  </script>
  