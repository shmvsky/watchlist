<template>
  <div class="d-flex flex-row gap-4 align-items-start">  
    <table class="table table-striped">
      <thead>
        <tr>
          <th scope="col">Имя</th>
          <th scope="col">Кол-во фильмов</th>
          <th scope="col">Рейтинг</th>
          <th scope="col"></th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="author in authors" :key="author.id">
          <td>
            {{ author.name }}
          </td>
          <td>
            {{ author.films_cnt }}
          </td>
          <td>
            {{ author.avg_rating }}
          </td>
          <td>
            <button class="btn btn-primary-secondary" @click="delAuthor(author.id)"><fa icon="trash"/></button>
          </td>
        </tr>
      </tbody>
    </table>

    <form class="d-flex flex-column align-items-start gap-2 p-4 border rounded w-50" @submit.prevent="submitForm" >
      <label class="form-label display-6">Имя автора</label>
      <InputText class="form-control" v-model="authorName" placeholder="Введите текст"/>
      <button class="btn btn-outline-dark text-left mt-3">Добавить</button>
    </form>
  </div>
</template>
  
  <script>
  import { getAuthors, deleteAuthor, createAuthor } from '../services/api';
  
  export default {
  data() {
    return {
    movies: [],
    authors: [],
    tags: [],
    sortOrder: 'asc',
    groupByType: '',
    authorName: null
    };
  },
  methods: {
    async fetchAuthors() {
    try {
      const [authorsResponse] = await Promise.all([getAuthors()]);
      this.authors = authorsResponse.data;
    } catch (error) {
      console.error(error);
    }
    },
    async delAuthor(author_id) {
    console.log(author_id);
    try {
      const [authorsResponse] = await Promise.all([deleteAuthor(author_id)]);
      if (authorsResponse.status === 204) {
        this.fetchAuthors();
      }
    } catch {
      console.error(error);
    }
    },
    async submitForm() {
      try {
        await createAuthor({
          "name": this.authorName
        });
        this.fetchAuthors();
      } catch (error) {
        console.error(error);
      }
    }
  },
  mounted() {
    this.fetchAuthors();
  }
  };
  </script>
