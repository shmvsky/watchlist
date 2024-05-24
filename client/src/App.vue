<template>
  <div class="min-h-screen text-bg-light">
    <div class="container">
      <div id="app">
        <ul class="nav nav-tabs mb-3">
          <li class="nav-item">
            <router-link to="/add-movie" class="nav-link">ADD MOVIE</router-link>
          </li>
          <li class="nav-item">
            <router-link to="/movies" class="nav-link">LIST MOVIES</router-link>
          </li>
          <li class="nav-item">
            <router-link to="/authors" class="nav-link">AUTHORS</router-link>
          </li>
        </ul>
        <router-view></router-view>
      </div>
    </div>
  </div>
</template>


<script>
export default {
  name: 'App'
};
</script>

<style>
</style>
