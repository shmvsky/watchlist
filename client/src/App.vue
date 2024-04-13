<template>
  <div class="vh-100 text-bg-light">
    <div class="h-100 container d-flex flex-row justify-content-around">
      <div class="films">
        <h1 class="display-4">Фильмы</h1>
        <Film/>
      </div>
      <div class="h-100 d-flex flex-column">
        <div class="h-50">
          <h1 class="display-5">Теги</h1>
          <Tag/>
        </div>
        <div class="h-50">
          <h1 class="display-5">Авторы</h1>
          <Author/>
        </div>
      </div>
    </div>
  </div>
  
</template>

<script setup>
import Tag from './components/Tag.vue'
</script>

<style scoped>
</style>
