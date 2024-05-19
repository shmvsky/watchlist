import axios from 'axios';

const BASE_URL = 'http://localhost:3000';

export const getAuthors = () => axios.get(`${BASE_URL}/authors`);
export const getAuthor = (id) => axios.get(`${BASE_URL}/authors/${id}`);
export const createAuthor = (author) => axios.post(`${BASE_URL}/authors`, author);
export const updateAuthor = (id, author) => axios.put(`${BASE_URL}/authors/${id}`, author);
export const deleteAuthor = (id) => axios.delete(`${BASE_URL}/authors/${id}`);

export const getTags = () => axios.get(`${BASE_URL}/tags`);
export const getTag = (id) => axios.get(`${BASE_URL}/tags/${id}`);
export const createTag = (tag) => axios.post(`${BASE_URL}/tags`, tag);
export const updateTag = (id, tag) => axios.put(`${BASE_URL}/tags/${id}`, tag);
export const deleteTag = (id) => axios.delete(`${BASE_URL}/tags/${id}`);

export const getFilms = () => axios.get(`${BASE_URL}/films`);
export const getFilm = (id) => axios.get(`${BASE_URL}/films/${id}`);
export const createFilm = (film) => axios.post(`${BASE_URL}/films`, film);
export const updateFilm = (id, film) => axios.put(`${BASE_URL}/films/${id}`, film);
export const deleteFilm = (id) => axios.delete(`${BASE_URL}/films/${id}`);
