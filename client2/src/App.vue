<template>
  <div id="app">
    <nav>
      <router-link to="/add-movie">Add Movie</router-link>
      <router-link to="/movies">Movie List</router-link>
    </nav>
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  name: 'App'
};
</script>

<style>
nav {
  display: flex;
  gap: 10px;
  margin-bottom: 20px;
}
</style>
