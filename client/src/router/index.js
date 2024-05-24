import { createRouter, createWebHistory } from 'vue-router';
import AddMovieView from '../views/AddMovieView.vue';
import MovieListView from '../views/MovieListView.vue';
import AuthorsListView from '../views/AuthorsListView.vue';

const routes = [
  {
    path: '/add-movie',
    name: 'AddMovie',
    component: AddMovieView
  },
  {
    path: '/movies',
    name: 'MovieList',
    component: MovieListView
  },
  {
    path: '/authors',
    name: 'AuthorsList',
    component: AuthorsListView
  },
  {
    path: '/',
    redirect: '/movies'
  }
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

export default router;
