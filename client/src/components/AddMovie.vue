<template>
  <div class="d-flex flex-row">

    <form action="" class="d-flex flex-column gap-2 p-4 border rounded w-50" @submit.prevent="submitForm">      
      <div class="">
        <label class="form-label display-6">Наименование</label>
        <InputText class="form-control" v-model="film.title" placeholder="Введите текст"/>
      </div>
      <div>
        <label class="form-label display-6">Заметка</label>
        <Textarea class="form-control" v-model="film.note" placeholder="Введите текст"/>
      </div>
      
      <div class="mt-2 d-flex flex-row gap-3">
        <Dropdown v-model="selectedStatus" checkmark  :options="statuses" optionLabel="name" placeholder="Установите статус"/>
        <Dropdown class="w-full" v-model="selectedAuthor" checkmark  :options="authors" optionLabel="name" placeholder="Выберите автора"/>
      </div>
      <MultiSelect v-model="selectedTags" display="chip" :options="tags" optionLabel="name" placeholder="Тэги"/>

      <div class="d-flex flex-row mt-2">
        <label class="display-6 mr-3">Оценка</label>
        <Rating v-model="film.rate" :cancel="false" class="mt-2" />
      </div>

      <button class="btn btn-outline-dark text-left mt-4">Сохранить</button>
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
      
      selectedStatus: null,
      selectedAuthor: null,
      selectedTags: [],

      statuses: [
        {"name": "Watched", "value": "0"},
        {"name": "Planned", "value": "1"},
        {"name": "Dropped", "value": "2"}
      ]
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
    async submitForm() {
      try {
        this.film.status = parseInt(this.selectedStatus.value);
        this.film.author_id = this.selectedAuthor.id
        this.film.tags = this.selectedTags.map(t => t.id);

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
